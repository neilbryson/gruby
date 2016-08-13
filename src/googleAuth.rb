#!/usr/bin/env ruby
require 'json'
require 'google/apis/gmail_v1'

module NeilBryson
  class GoogleAuth

    ##
    # The GoogleAuth API
    ##
    gAuth = Google::Auth
    @@gAuthDefaultCreds = gAuth::DefaultCredentials

    ##
    # @param string scope The Auth Scopes / permissions
    # @param string credentialsJsonPath The path to the JSON credentials file
    # @param class service The Google API service
    ##
    def initialize(scope, credentialsJsonPath, service)
      @credentialsJsonPath = credentialsJsonPath
      @scope = scope
      @service = service
    end

    ##
    # Load the Google-generated credentials file.
    #
    # @return IO io
    ##
    def loadCredentialsFile
      fd = IO.sysopen(@credentialsJsonPath, 'r')
      io = IO.new(fd, 'r')
      io
    end

    ##
    # Retrieve the access token
    #
    # @return array The access token
    ##
    def authorise
      @jsonKeyIo = self.loadCredentialsFile
      gAuthDefaultCreds = @@gAuthDefaultCreds
      serviceAccountCredentials = gAuthDefaultCreds.make_creds(
        {:json_key_io => @jsonKeyIo, :scope => @scope})
      @service.authorization = serviceAccountCredentials
      @service.authorization.fetch_access_token
    end

  end

end
