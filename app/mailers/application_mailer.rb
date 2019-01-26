class ApplicationMailer < ActionMailer::Base
  default from: 'sales-team@amazon.com'
  layout 'mailer'
end
