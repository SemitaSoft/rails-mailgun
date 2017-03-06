class Templates::BatchSendsController < ApplicationController
  def create
    @template = Template.find params[:template_id]
    @message  = build_message
    @message.finalize
    head :ok
  end

  private

  def build_client
    Mailgun::Client.new(api_key)
  end

  def build_message
    Mailgun::BatchMessage.new(build_client, ENV['SENDER_DOMAIN']).tap do |msg|
      msg.from(@template.from, {'first' => @template.name})
      msg.subject(@template.title)
      msg.body_text(@template.textcontent)
      get_all_recipients['items'].each do |rec|
        msg.add_recipient(:to, rec['address'], rec['vars'])
      end
    end
  end

  def get_all_recipients
    JSON.parse(get_list_members)
  end

  def get_list_members
    RestClient.get("https://api:#{api_key}@api.mailgun.net/v3/lists/#{params[:email]}/members/pages")
  end

  def api_key
    ENV['API_KEY']
  end
end
