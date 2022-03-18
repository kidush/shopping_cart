require_relative '../cart'

RSpec.describe Cart do 
  describe 'Add products to the shopping cart.' do
    context 'Given an empty shopping cart and products are added to the cart' do
      it 'returns the number of products on the cart' do
        Product = Struct.new('Product', :name, :price)
        product = Product.new("Dove Soaps", 3999)

        cart = described_class.new 
        cart.add(product: product, amount: 5)

        expect(cart.size).to eq 5
      end

      it "returns the shopping's total price" do
        Product = Struct.new('Product', :name, :price)
        product = Product.new("Dove Soaps", 3999)

        cart = described_class.new 
        cart.add(product: product, amount: 5)

        expect(cart.total_price).to eq 199.95
      end
    end

    context 'Given an empty shopping cart' do
      context 'When the user adds 5 products of type A and add more 3 products of the same type' do
        it 'returns a list of 8 products of type A' do
          Product = Struct.new('Product', :name, :price)
          product = Product.new("Dove Soaps", 3999)

          cart = described_class.new
          cart.add(product: product, amount: 5)
          cart.add(product: product, amount: 3)

          expect(cart.size).to eq 8
        end

        it 'returns the total price of 8 products of the type A' do
          Product = Struct.new('Product', :name, :price)
          product = Product.new("Dove Soaps", 3999)

          cart = described_class.new
          cart.add(product: product, amount: 5)
          cart.add(product: product, amount: 3)

          expect(cart.total_price).to eq 319.92
        end
      end
    end

    context 'Given an empty shopping cart' do
      context 'When the user adds 2 products of type A and add more 2 products of the type B' do
        it 'returns a list of 4 products' do
          Product = Struct.new('Product', :name, :price)
          product_a = Product.new("Dove Soaps", 3999)
          product_b = Product.new("Axe Deo", 9999)

          cart = described_class.new
          cart.add(product: product_a, amount: 2)
          cart.add(product: product_b, amount: 2)

          expect(cart.size).to eq 4
        end

        it 'returns the total price with the sale tax' do
          Product = Struct.new('Product', :name, :price)
          product_a = Product.new("Dove Soaps", 3999)
          product_b = Product.new("Axe Deo", 9999)

          cart = described_class.new
          cart.add(product: product_a, amount: 2)
          cart.add(product: product_b, amount: 2)

          expect(cart.total_price(tax: true)).to eq 314.96
          expect(cart.sale_tax).to eq 35.00
        end

        context 'When the users add the products and want to figure out how many products they have of a certain type' do
          it 'returns the size of the specified type' do
            Product = Struct.new('Product', :name, :price)
            product_a = Product.new("Dove Soaps", 3999)
            product_b = Product.new("Axe Deo", 9999)

            cart = described_class.new
            cart.add(product: product_a, amount: 2)
            cart.add(product: product_b, amount: 2)

            expect(cart.items_size_from(product: product_a)).to eq 2
          end
        end

        context 'When the users add the products and want to remove an item of a specified type' do
          it 'removes the specified type from the cart' do
            Product = Struct.new('Product', :name, :price)
            product_a = Product.new("Dove Soaps", 3999)
            product_b = Product.new("Axe Deo", 9999)

            cart = described_class.new
            cart.add(product: product_a, amount: 2)
            cart.add(product: product_b, amount: 2)

            cart.remove_item(product: product_b, amount: 1)

            expect(cart.size).to eq 3
          end
        end
      end
    end
  end  
end
