class AvatarComponent < ViewComponent::Base
  def initialize(name:, email: nil, size: :md, src: nil)
    @name = name
    @email = email
    @size = size
    @src = src
  end

  private

  attr_reader :name, :email, :size, :src

  def size_classes
    case size
    when :sm
      "w-8 h-8 text-xs"
    when :md
      "w-10 h-10 text-sm"
    when :lg
      "w-12 h-12 text-base"
    when :xl
      "w-16 h-16 text-lg"
    else
      "w-10 h-10 text-sm"
    end
  end

  def initials
    return "" if name.blank? || name.strip.blank?
    
    words = name.strip.split
    return "" if words.empty?
    
    if words.length == 1
      words.first.first.upcase
    else
      # První a poslední slovo
      "#{words.first.first}#{words.last.first}".upcase
    end
  end

  def avatar_url
    return src if src.present?
    return nil unless email.present?
    
    # Gravatar URL
    require 'digest'
    hash = Digest::MD5.hexdigest(email.downcase.strip)
    "https://www.gravatar.com/avatar/#{hash}?d=identicon&s=#{size_pixels}"
  end

  def size_pixels
    case size
    when :sm then 32
    when :md then 40
    when :lg then 48
    when :xl then 64
    else 40
    end
  end

  def background_color
    # Generuj konzistentní barvu z jména
    colors = [
      "bg-blue-500", "bg-green-500", "bg-purple-500", "bg-pink-500",
      "bg-yellow-500", "bg-indigo-500", "bg-red-500", "bg-teal-500"
    ]
    colors[name.sum % colors.length]
  end
end 