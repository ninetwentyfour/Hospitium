class NotesChannel < ApplicationCable::Channel
  # def subscribed
  #   stream_from 'messages'
  # end
  def subscribed
    # stream_from 'messages'
    stream_from "notes_#{params[:id]}"

    # post = Animal.find(params[:id])
    # stream_for post
  end
end
