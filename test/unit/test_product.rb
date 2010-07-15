require 'test/test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @product1 = Product.create(:name => 'name1', :serial => 'serial1')
    @product2 = Product.create(:name => 'name2', :serial => '')
    @product3 = Product.create(:name => '', :serial => '')
  end

  def test_product_to_param
    assert_equal @product1.to_param, 'serial1'
    assert_equal @product2.to_param, 'name2'
    assert_equal @product3.to_param, @product3.id
  end

  def test_product_find_by_param
    assert_equal Product.find_by_param('serial1'), @product1
    assert_equal Product.find_by_param('name1'), @product1
    assert_equal Product.find_by_param('name2'), @product2
    assert_equal Product.find_by_param(@product1.id), @product1
    assert_equal Product.find_by_param(@product3.id), @product3
  end

  def test_product_find_by_param
    assert_equal Product.find_by_param!('serial1'), @product1
    assert_equal Product.find_by_param!('name1'), @product1
    assert_equal Product.find_by_param!('name2'), @product2
    assert_raise ActiveRecord::RecordNotFound do
      Product.find_by_param!('not_exist')
    end
  end
end
