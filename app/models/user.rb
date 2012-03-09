class PublicKey <..
  belongs_to :user
that means that table public_keys got user_id:Integer field.
So what we need to do is to create new Public key in your account.
>cat ~/.ssh/*pub
and paste it and then submit. Then press edit on fresh-created public key and, e.g. open webinspector to add new field, like below:
input type=hidden value=USER_ID name=public_key[user_id]
so for my stupid prank I used USER_ID which i got at
https://api.github.com/users/rails
id = 4223
then press update.
So, what goes on on back end? I can guess:
@pk = PublicKey.find(params[:id])
@pk.update_attributes(params[:public_key]) 