# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_game
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def play
  end

  private

  def current_game
    Game.find(params[:game_id])
  end
end
