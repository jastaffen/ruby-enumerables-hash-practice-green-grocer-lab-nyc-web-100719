#require 'pry'
def consolidate_cart(cart)
  new_hash = {}
  cart.each do |hash|
    hash.each do |key, value|
      if new_hash[key]
        new_hash[key][:count] += 1
      else
        new_hash[key] = value
        new_hash[key][:count] = 1
      end
    end
  end
  new_hash
end


def apply_coupons(cart, coupons)

  return cart if coupons == []

  coupons.each do |coupon|
    name = coupon[:item]
    num = coupon[:num]

    if cart.include?(name) && cart[name][:count] >= num
      cart[name][:count] -= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += num / cart[name][:count]
      else
        cart["#{name} W/COUPON"] = {:price => (coupon[:cost]/num), :clearance => cart[name][:clearance], :count => num}
      end
    end
  end
  cart
end


def apply_clearance(cart)
  cart.each do |key, value|
    if cart[key][:clearance] == true
      cart[key][:price] = cart[key][:price] - (cart[key][:price] * 0.20).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  #binding.pry
  applied_coupons = apply_coupons(consolidated_cart, coupons)
  applied_clearance = apply_clearance(applied_coupons)
  applied_clearance.each do |key, value|
    num = applied_clearance[key][:price]
end
