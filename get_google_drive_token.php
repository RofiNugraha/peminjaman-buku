<?php

require __DIR__ . '/vendor/autoload.php';

use GuzzleHttp\Client;

$clientSecretPath = __DIR__ . '/storage/app/google-drive/client_secret.json';

if (!file_exists($clientSecretPath)) {
    echo "client_secret.json not found. Please copy your JSON credentials to storage/app/google-drive/client_secret.json\n";
    exit(1);
}

$credentials = json_decode(file_get_contents($clientSecretPath), true);

if (empty($credentials['installed'])) {
    echo "Invalid credentials file. Expected 'installed' object in JSON.\n";
    exit(1);
}

$clientId = $credentials['installed']['client_id'] ?? null;
$clientSecret = $credentials['installed']['client_secret'] ?? null;
$redirectUris = $credentials['installed']['redirect_uris'] ?? [];
$redirectUri = $redirectUris[0] ?? 'urn:ietf:wg:oauth:2.0:oob';

if (!$clientId || !$clientSecret) {
    echo "Client ID or client secret is missing in client_secret.json.\n";
    exit(1);
}

$authUrl = sprintf(
    'https://accounts.google.com/o/oauth2/v2/auth?client_id=%s&redirect_uri=%s&response_type=code&scope=%s&access_type=offline&prompt=consent',
    urlencode($clientId),
    urlencode($redirectUri),
    urlencode('https://www.googleapis.com/auth/drive')
);

echo "Open this URL in your browser and authorize the app:\n\n";
echo $authUrl . "\n\n";
echo "Enter the authorization code: ";

$authCode = trim(fgets(STDIN));

if (empty($authCode)) {
    echo "Authorization code is required.\n";
    exit(1);
}

$guzzle = new Client(['timeout' => 30]);
$response = $guzzle->post('https://oauth2.googleapis.com/token', [
    'form_params' => [
        'code' => $authCode,
        'client_id' => $clientId,
        'client_secret' => $clientSecret,
        'redirect_uri' => $redirectUri,
        'grant_type' => 'authorization_code',
    ],
]);

$data = json_decode((string) $response->getBody(), true);

if (isset($data['error'])) {
    echo "Failed to fetch access token:\n" . json_encode($data, JSON_PRETTY_PRINT) . "\n";
    exit(1);
}

if (empty($data['refresh_token'])) {
    echo "No refresh token was returned. Make sure you authorized with offline access and consent prompt.\n";
    exit(1);
}

echo "\n✅ Refresh token obtained successfully:\n\n";
echo "GOOGLE_DRIVE_REFRESH_TOKEN=" . $data['refresh_token'] . "\n";