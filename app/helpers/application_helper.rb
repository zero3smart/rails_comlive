module ApplicationHelper

  def title(page_title)
    if page_title
      content_for :title, page_title.to_s.titleize + " | #{t("sitename")}"
    else
      content_for :title, t("sitename")
    end
  end

  def errors_for(object)
    if object.errors.any?
      content_tag :div, class: "alert alert-dismissable alert-danger hidden" do
        concat '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>'.html_safe
        concat content_tag(:h3, "Oh Snap!")
        object.errors.full_messages.each do |msg|
          concat content_tag(:p, msg)
        end
      end
    end
  end

  def flash_class(level)
    case level.to_sym
      when :notice then "alert alert-success"
      when :info then "alert alert-info"
      when :alert then "alert alert-danger"
      when :warning then "alert alert-warning"
    end
  end

  def gravatar_for(email, size = 50, classes = "")
    hash = Digest::MD5.hexdigest(email)
    image_tag "https://www.gravatar.com/avatar/#{hash}?s=#{size}&d=identicon", class: classes
  end

  def options_for_visibility(record)
    descriptions = {
        publicized: { text: t("publishing.public").html_safe, title: "Public" },
        privatized: { text: t("publishing.private"), title: "Private"  },
        official: { text: t("publishing.official"), title: "Official" }
    }
    record.class.visibilities.map do |k,v|
      [descriptions[k.to_sym][:title], k, data: { subtext: descriptions[k.to_sym][:text]}]
    end
  end

  def errors_for_field(model,attribute)
    if model.errors[attribute].present?
      content_tag :span, class: 'help-block' do
        model.errors[attribute].join(", ")
      end
    end
  end

  def initials_for(app)
    return unless app.valid?
    app.name.chars.first.upcase
  end
end
