class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :show_session_user

  def layout
    if current_user
    @layout = "logged_in"
    else
    @layout = "not_logged_in"
    end

    render(:layout => "#{@layout}")
  end

  def authorize
      if current_user.nil?
        redirect_to :new_login
      end
    end



    # Return either `nil` or a User object.
    def current_user
      if session[:user_id]
        @current_user ||= User.find(session[:user_id])
      end
    end
    helper_method :current_user

    def show_session_user
      puts "\n\n\n-------------- #{session[:user_id]} ------------\n\n\n"
    end

    helper_method :markdown

    def markdown(text)
        options = {
          filter_html:    true,
          hard_wrap:      true,
          link_attributes: { rel: 'nofollow' },
          space_after_headers: true,
          fenced_code_blocks: true
        }

        extensions = {
          autolink:          true,
          superscript:        true,
          disable_indented_code_blocks: true
        }

        renderer = Redcarpet::Render::HTML.new(options)
        markdown = Redcarpet::Markdown.new(renderer, extensions)

        markdown.render(text).html_safe
      end

      def check_admin
        @admins = ['ytmoik@gmail.com', 'mikejtodd@gmail.com', 'ja.lueth@gmail.com']
        @admins.include?(current_user.email)
      end

end
