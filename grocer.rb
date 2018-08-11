require "pry"

def consolidate_cart(cart)
  newHash = {}

  cart.each do |item, item_info|
    item.each do |food, food_facts|
      newHash[food] = {}
    end
  end
  newHash

  cart.each do |item, item_info|
    item.each do |food, food_facts|
      food_facts.each do |key, value|
        newHash[food][key] = value
        newHash[food][:count] = 0
      end
    end
  end
  newHash
  cart.each do |item, item_info|
    item.each do |food, food_facts|
      if newHash.include?(food)
        newHash[food][:count] += 1
      end
    end
  end
  newHash
end


def apply_coupons(cart, coupons)
  newCart = cart

  coupons.each do |info, coupon_hashes|
    info.each do |key, value|
      if cart.keys.include?(info[:item])

        items_required = info[:num]
        items_in_cart = cart[info[:item]].fetch(:count)

        if items_in_cart >= items_required
          coupon_deals = (items_in_cart / items_required).floor
          remainder = items_in_cart % items_required
          food_name = info[:item]
          discounted_items = "#{food_name} W/COUPON"
          newCart[discounted_items] = {:price => info[:cost], :clearance => cart[food_name][:clearance], :count => coupon_deals}
          newCart[info[:item]][:count] = remainder
        end
      end
    end
  end
  newCart
end








def apply_clearance(cart)
  newCart = {}

  cart.each do |item, item_info|
    item_info.each do |key, value|
      if item_info[:clearance] == false
        newCart[item] = item_info
      elsif item_info[:clearance] == true

        discounted_price = item_info[:price] * 0.8
        newCart[item] = {:price => discounted_price.round(2), :clearance => true, :count => cart[item][:count]}

      end
    end
  end
  newCart
end



def checkout(cart, coupons)
  cart_summary = consolidate_cart(cart)
  cart_with_coupons = apply_coupons(cart_summary, coupons)
  cart_with_clearance = apply_clearance(cart_with_coupons)

  prices = []

  cart_with_clearance.each do |item, item_info|
    item_info.each do |key, value|
      prices << item_info[:price]
    end
  end

  prices
  sum = 0
  i = 0

  while i < prices.length
    sum += prices[i]
    i += 1
  end
  sum
  if sum > 100
    discount_sum = sum * 0.9
  else
    discount_sum = sum
  end
  binding.pry
end
