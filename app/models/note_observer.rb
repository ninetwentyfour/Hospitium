require 'juggernaut'

class NoteObserver < ActiveRecord::Observer
  def after_create(note)
    publish(:create, note)
  end

  def publish(type, note)
    Juggernaut.url = ENV['JUGG_URL']
    Juggernaut.publish("/observer/note/#{note.animal.id}", id: note.id,
                                                           type: type,
                                                           created_at: Time.now.strftime('%a, %b %e at %l:%M'),
                                                           klass: note.class.name,
                                                           record: note,
                                                           user: note.username)
  end
end
