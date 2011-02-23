FormMail, the nostalgic form to mail handler
==============================================

Overview
--------

Remember the times of slow dial-ups, Netscape Navigator and 5MB web hosting?
Or perhaps you are simply building a tiny static website but still need a way
to send email from a form. And you definitely don't want to install a big
application framework just for that.

FormMail makes it dead simple:

1.  Install FormMail (it's just the config.ru, really). For extra nostalgy
    points, don't use [capistrano](http://capify.org) or anything like that;
    just upload it using your favorite SFTP client!
    
2.  Edit it to match your setup (see inline documentation).

3.  Create or edit your form to match (see below for details).

4.  Configure your Rack (Passenger, Thin, Mongrel) server to run FormMail.

5.  Test it!

Integration
-----------

FormMail by defaults accepts only POST requests to `/send` (but you can easily
change that). A simple form like this would work out of the box:

    <form method="POST" action="/send" id="contacts">
    <p>
      <label for="name">You name</label>
      <input type="text" id="name" value="" name="name"/>
    </p>
    <p>
      <label for="email">Email</label><br/>
      <input type="text" id="email" value="" name="email"/>
    </p>
    <p>
      <label for="body">Commenti // Domande</label><br/>
      <textarea id="body" name="body" rows="8" cols="60"></textarea>
    </p>
    <input type="submit"/>
    </form>

However, the answer would be blank, and besides, we are not *that* nostalgic!

In fact, FormMail prefers Ajax:

    var sendEmail: function() {
      jQuery.ajax({
        type: "POST",
        url: 'http://example.com/send',
        data: $('#contacts').serialize(),
        dataType: 'text',
        success: function(msg){
          $('#contactform input.btn').fadeIn();
          if (msg) {
            $('#contacts').prepend('<p class="error">' + msg + '</p>');
          } else {
            var parent = $('#contacts').parent();
            $('#contacts').remove();
            parent.append('<p><b>Email sent!</b></p>');
          }
        },
        error: function(msg) {
            $('#contacts').prepend('<p class="error">' + msg + '</p>');
        }
      });

