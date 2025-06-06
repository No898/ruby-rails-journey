class BoutiqueInventory
  def initialize(items)
    @items = items
  end

  def item_names
    @items.map{|items| items[:name]}.sort
  end

  def cheap
    @items.select { |items| items[:price] < 30}
  end

  def out_of_stock
    @items.select{ |items| items[:quantity_by_size].empty?}
  end

  def stock_for_item(name)
    @items.find{|items| items[:name] == name}[:quantity_by_size]
  end

  def total_stock
    @items.sum{|items| items[:quantity_by_size].values.sum}
  end

  private
  attr_reader :items  
end
