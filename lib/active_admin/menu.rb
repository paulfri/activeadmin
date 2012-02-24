module ActiveAdmin

  class Menu

    attr_accessor :children

    def initialize
      @children = Menu::ItemCollection.new

      yield(self) if block_given?
    end

    # Add a new MenuItem to the menu
    #
    # Example:
    #   menu = Menu.new
    #   dash = MenuItem.new :label => "Dashboard"
    #   menu.add dash
    #
    # Accepts as many menu items as you wish to add:
    #
    #   menu = Menu.new
    #   dash = MenuItem.new :label => "Dashboard"
    #   admin = MenuItem.new :label => "Admin"
    #   menu.add dash, admin
    #
    # @param [MenuItem] menu_items Add as many menu items as you pass in
    def add(*menu_items)
      menu_items.each do |menu_item|
        menu_item.parent = nil
        @children << menu_item
      end
    end

    def [](id)
      @children.find_by_id(id)
    end

    def items
      @children.sort
    end

    class ItemCollection < Array

      def find_by_id(id)
        id = MenuItem.generate_item_id(id)
        find{ |i| i.id == id }
      end

    end

  end

end
