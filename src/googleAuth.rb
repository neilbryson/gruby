#!/usr/bin/env ruby
require 'google/apis/gmail_v1'
require 'google/apis/drive_v2'

module NeilBryson
  class GoogleAuth

    ##
    # The GoogleAuth API
    ##
    gAuth = Google::Auth
    @@gAuthJwtService = gAuth::ServiceAccountJwtHeaderCredentials
    @@gAuthDefaultCreds = gAuth::DefaultCredentials

    ##
    # @param [string] scope The Auth Scopes / permissions
    # @param [string] credentialsJsonPath The path to the JSON credentials file
    # @param [class] service The Google API service
    # @param [nil|string] sub The account for impersonation. Will only work for
    #   Google Domain accounts. Required for Gmail.
    ##
    def initialize(scope, credentialsJsonPath, service, sub = nil)
      @credentialsJsonPath = credentialsJsonPath
      @scope = scope
      @service = service
      @sub = sub
    end

    ##
    # Load the Google-generated credentials file.
    # @return [IO] io
    ##
    def loadCredentialsFile
      fd = IO.sysopen(@credentialsJsonPath, 'r')
      io = IO.new(fd, 'r')
      io
    end

    ##
    # Retrieve the access token
    # @return [array] The access token
    ##
    def authorise
      @jsonKeyIo = self.loadCredentialsFile
      gAuthDefaultCreds = @@gAuthDefaultCreds
      serviceAccountCredentials = gAuthDefaultCreds.make_creds(
        {json_key_io:  @jsonKeyIo, scope: @scope})
      @service.authorization = serviceAccountCredentials
      if ! @sub.nil?
        # Assign account for impersonation
        @service.authorization.sub = @sub
      end
      @service.authorization.fetch_access_token!
    end

  end

end
