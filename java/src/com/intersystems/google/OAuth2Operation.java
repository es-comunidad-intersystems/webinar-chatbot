package com.intersystems.google;

import java.io.FileInputStream;
import java.util.Arrays;

import com.google.auth.oauth2.AccessToken;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.auth.oauth2.ServiceAccountCredentials;
import com.intersystems.enslib.pex.*;

public class OAuth2Operation extends BusinessOperation {
    
    /** Google Service Account credentials file (path) */
    public String CredentialsFile;

    /**
     * Returns a valid token given a Google Service Account credentials file
     */
    public Object OnMessage(Object request) throws Exception {
        OAuth2Message response = new OAuth2Message();
        
        ServiceAccountCredentials credentials = ServiceAccountCredentials.fromStream(new FileInputStream(CredentialsFile));
        credentials = (ServiceAccountCredentials) credentials.createScoped(Arrays.asList("https://www.googleapis.com/auth/dialogflow"));
        credentials.refreshIfExpired();
        AccessToken token = credentials.getAccessToken();
        // or AccessToken token = credentials.refreshAccessToken();

        response.tokenValue = token.getTokenValue();
        
        return response;
    }
}
