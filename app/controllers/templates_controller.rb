class TemplatesController < ApplicationController
  before_action :set_template, only: [:show, :edit, :update, :destroy]

  def index
    @templates = Template.all
  end

  def show
    @total = JSON.parse(get_mailing_lists)
  end

  def new
    @template = Template.new
  end

  def create
    @template = Template.new(template_params)
      if @template.save
        redirect_to @template, notice: 'Template was successfully created.'
      else
        render :new
      end
  end

  def update
      if @template.update(template_params)
        redirect_to @template, notice: 'Template was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    redirect_to :root if @template.destroy
  end

  def sendd
    template = Template.find(params[:id])
    if sendall(template.title, template.textcontent, template.content, template.from, template.name)
      @templates = Template.all
      render :index, notice: 'Mails have been successfully send'
    else
    end
  end

  private
  def set_template
    @template = Template.find(params[:id])
  end

  def template_params
    params.require(:template).permit(:content, :textcontent, :title, :from, :name)
  end

  def get_mailing_lists
    RestClient.get("https://api:#{ENV["API_KEY"]}" \
                 "@api.mailgun.net/v3/lists/pages")
  end

  def list_members(list)
    RestClient.get("https://api:#{ENV["API_KEY"]}" \
                 "@api.mailgun.net/v3/lists/#{list}/members/pages")
  end

  def send_message(mail, title, text, html, from, name)
    mg_client = Mailgun::Client.new("#{ENV["API_KEY"]}")
    mb_obj = Mailgun::MessageBuilder.new
    mb_obj.from("#{from}", {"first"=>"#{name}"})
    mb_obj.add_recipient(:to, "#{mail}")
    mb_obj.subject("#{title}")
    mb_obj.body_text("#{text}")
    contents = "#{html}"
    mb_obj.body_html("#{contents}")
    mb_obj.track_clicks(true)
    mg_client.send_message("#{ENV["SENDER_DOMAIN"]}", mb_obj).to_h
  end

  def sendall(title, text, html, from, name)
    sendlist = JSON.parse(list_members(params[:email]))
    sendlist["items"].each do |message|
      send_message(message["address"], title, text, html, from, name)
    end
    true
  end
end
