#!/usr/bin/env ruby
require 'google/apis/drive_v2'
require_relative 'googleAuth.rb'

module NeilBryson
  module GoogleApis

    class GDrive

      @@googleAuth = NeilBryson::GoogleAuth

      @@gdrive = Google::Apis::DriveV2

      @@service = @@gdrive::DriveService.new

      @@scope = @@gdrive::AUTH_DRIVE_READONLY

      @@defaultCredentialsFilePath = File.join(File.dirname(__FILE__), 
        '../conf/credentials.json')

      def initialize(credentialsJsonPath = @@defaultCredentialsFilePath, 
        scope = @@scope, service = @@service)
        @credentialsJsonPath = credentialsJsonPath
        @scope = scope
        @service = service
        # Authorise the app and retrieve the access token
        @ccessToken = @@googleAuth.new(@scope, @credentialsJsonPath, @service)
          .authorise
      end

      def listFiles
        files = @service.list_files
        fileList = files.items
      end

    end

  end

end
