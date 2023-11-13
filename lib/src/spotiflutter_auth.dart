import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/spotify_oauth2_client.dart';
import 'package:spotiflutter_auth/spotiflutter_auth.dart';

class SpotiflutterAuth {
  Future<TokenData> authenticate({
    required String clientId,
    required String clientSecret,
    required String customUriScheme,
    required String redirectUri,
  }) async {
    SpotifyOAuth2Client client = SpotifyOAuth2Client(
      customUriScheme: customUriScheme,
      redirectUri: redirectUri,
    );

    var authResp = await client.requestAuthorization(
      clientId: clientId,
      customParams: {
        'show_dialog': 'true',
      },
      scopes: [
        'user-read-private',
        'user-read-playback-state',
        'user-modify-playback-state',
        'user-read-currently-playing',
        'user-read-email',
      ],
    );

    AccessTokenResponse response = await client.requestAccessToken(
      code: authResp.code.toString(),
      clientId: clientId,
      clientSecret: clientSecret,
    );

    return TokenData(
      expiresIn: response.expiresIn,
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
    );
  }
}
