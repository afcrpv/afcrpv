module Refinery
  module Projets
    class ProjetMailer < ActionMailer::Base

      def confirmation(projet, request)
        @projet = projet
        mail :subject   => Refinery::Projets::Setting.confirmation_subject(Globalize.locale),
             :to        => projet.email,
             :from      => "\"#{Refinery::Core.site_name}\" <no-reply@#{request.domain}>",
             :reply_to  => Refinery::Projets::Setting.notification_recipients.split(',').first
      end

      def notification(projet, request)
        @projet = projet
        mail :subject => Refinery::Projets::Setting.notification_subject,
             :to      => Refinery::Projets::Setting.notification_recipients,
             :from    => "\"#{Refinery::Core.site_name}\" <no-reply@#{request.domain}>"
      end

    end
  end
end
