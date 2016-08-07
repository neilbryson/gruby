#!/usr/bin/env ruby
require 'json'
require 'google/apis/gmail_v1'

class GoogleAuth

    ##
    # The default location of the credentials file
    #
    # /path/to/project/conf/credentials.json
    #
    # Of course, this can be overwritten on the initialize method
    @@defaultCredentialsFilePath = File.join(File.dirname(__FILE__), 
        '../conf/credentials.json')

    @gmail = Google::Apis::GmailV1

    def initialize(credentialsJsonPath = @@defaultCredentialsFilePath)
        @credentialsJsonPath = credentialsJsonPath
    end

    # Retrieve the Gmail username and the Google app password.
    #
    # @return array json
    def parseCredentialsFile
        file = File.read(@credentialsJsonPath)
        json = JSON.parse(file)
        if ! json['email'] || ! json['app_password']
            raise "Credentials file must have email and app_password"
        end
        json
    end

    def authenticate
        @credentials = self.parseCredentialsFile
        tokenStore = Google::Apis::GmailV1.new
        puts tokenStore
    end

end
