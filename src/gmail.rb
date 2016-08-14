#!/usr/bin/env ruby
require_relative 'googleAuth.rb'

module NeilBryson
  module GoogleApis

    class Gmail

      @@googleAuth = NeilBryson::GoogleAuth

      @@gmail = Google::Apis::GmailV1

      ##
      # The Gmail API service.
      # This can be overridden in the initialize method.
      ##
      @@service = @@gmail::GmailService.new

      ##
      # We need this to permit our service account to modify draft messages.
      # This can be overridden in the initialize method.
      #
      # I just found out that a normal Gmail (@gmail.com) email accounts will not
      # work on Service Accounts. Gmail for Work / Business is required.
      ##
      @@scope = @@gmail::AUTH_GMAIL_COMPOSE

      ##
      # By default, the JSON credentials key file is located here.
      # This can be overridden in the initialize method.
      ##
      @@defaultCredentialsFilePath = File.join(File.dirname(__FILE__), 
        '../conf/credentials.json')

      ##
      # @param [string] credentialsJsonPath The path to the JSON credentials
      # @param [string|array] scope The scopes for accessing the API
      # @see https://developers.google.com/gmail/api/auth/scopes
      ##
      def initialize(credentialsJsonPath = @@defaultCredentialsFilePath, 
        scope = @@scope, service = @@service)
        @credentialsJsonPath = credentialsJsonPath
        @scope = scope
        @service = service
        # Authorise the app and retrieve the access token
        @ccessToken = @@googleAuth.new(@scope, @credentialsJsonPath, @service)
          .authorise
      end

    end

  end

end