require 'line/bot/api/version'
require 'line/bot/utils'

module Line
  module Bot
    class Processor
      attr_accessor :client, :data, :to_mid

      def initialize(client, data)
        @client = client
        @data = data
        @to_mid = data.from_mid
      end

      def process
        case data
        when Line::Bot::Receive::Operation
          case data.content
          when Line::Bot::Operation::AddedAsFriend
            3.times do
              client.send_text(
                to_mid: to_mid,
                text: initial_processor(i),
              )
            end
          end
        when Line::Bot::Receive::Message
          case data.content
          when Line::Bot::Message::Text
            3.times do
              client.send_text(
                to_mid: to_mid,
                text: initial_processor(i),
              )
            end
          end
        end
      end

      private
      def initial_processor(count)
        message = ""

        case count
        when 0
          user = User.where(mid: to_mid).first_or_initialize
          user.save!
          message += "ご登録ありがとうございます！"
          message += "\nイベントを逃さず遊びつくしましょう！"
        when 1
          message += "\n今開催中のおすすめイベントはこちら！"
        when 2
          Event.all.each do |event|
            message += "\n---------------------------------------"
            message += "\n#{event.name}"
            message += "\n#{event.event_url}"
          end
        end

        message
      end

      def text_processor
      end
    end
  end
end
