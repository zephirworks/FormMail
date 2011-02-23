require 'sinatra'
require 'pony'

recipient = 'me@example.com'
mail_from = 'web@example.com'

sender    = "#{params[:name]} <#{mail_from}>"
subject   = "Email from the website (#{params[:email]})"
body      = params[:body]

options = { :to => recipient,
            :from => sender,
            :subject => subject,
            :body => body }

#
# Bring your own MTA: Pony will by default send email via the local sendmail
# (or equivalent) MTA. If you want to use an external service (your ISP, Gmail
# or some bulk mailing service) you should uncomment the following lines and
# enter your account information. The available options are documented at
# https://github.com/benprew/pony .
#
# options.merge!( :via => :smtp,
#                 :via_options => {
#                   :address => 'mail.example.com',
#                   :port    => '25' })

post '/send' do
  Pony.mail(options)
  "" # send nothing on success
end

run Sinatra::Application
