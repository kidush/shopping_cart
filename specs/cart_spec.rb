require_relative '../cart'
require_relative '../product'

RSpec.describe Cart do
  describe 'Add products to the shopping cart.' do
    context 'Given an empty shopping cart and products are added to the cart' do
      it 'returns the number of products on the cart' do
        product = Product.new("Dove Soaps", 3999)

        cart = described_class.new 
        cart.add(product: product, amount: 5)

        expect(cart.size).to eq 5
      end

      it "returns the shopping's total price" do
        product = Product.new("Dove Soaps", 3999)

        cart = described_class.new 
        cart.add(product: product, amount: 5)

        expect(cart.total_price).to eq 199.95
      end
    end

    context 'Given an empty shopping cart' do
      context 'When the user adds 5 products of type A and add more 3 products of the same type' do
        it 'returns a list of 8 products of type A' do
          product = Product.new("Dove Soaps", 3999)

          cart = described_class.new
          cart.add(product: product, amount: 5)
          cart.add(product: product, amount: 3)

          expect(cart.size).to eq 8
        end

        it 'returns the total price of 8 products of the type A' do
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
          product_a = Product.new("Dove Soaps", 3999)
          product_b = Product.new("Axe Deo", 9999)

          cart = described_class.new
          cart.add(product: product_a, amount: 2)
          cart.add(product: product_b, amount: 2)

          expect(cart.size).to eq 4
        end

        it 'returns the total price with the sale tax' do
          product_a = Product.new("Dove Soaps", 3999)
          product_b = Product.new("Axe Deo", 9999)

          cart = described_class.new
          cart.add(product: product_a, amount: 2)
          cart.add(product: product_b, amount: 2)

          expect(cart.total_price(tax: true)).to eq 314.96
          expect(cart.total_tax).to eq 35.00
        end

        context 'When the users add the products and want to figure out how many products they have of a certain type' do
          it 'returns the size of the specified type' do
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
            product_a = Product.new("Dove Soaps", 3999)
            product_b = Product.new("Axe Deo", 9999)

            cart = described_class.new
            cart.add(product: product_a, amount: 2)
            cart.add(product: product_b, amount: 2)

            cart.remove_item(product: product_b, amount: 1)

            expect(cart.size).to eq 3
          end
        end

        # Given the customer has 4 _Dove Soaps_ and 2 _Axe Deos_ in their cart
        # 	When the customer removes 1 _Dove Soap_
        # 	Then the number of _Dove Soaps_ should be 3
        # 	And the total & the sales tax should reflect the change
        # 	Expected totals =>
        # 		Total tax = 39.99
        # 		Total price = 359.94

        context 'Given the customer has 4 _Dove Soaps_ and 2 _Axe Deos_ in their cart' do
          context 'When the customer removes 1 _Dove Soap_' do
            before(:each) do
              product_a = Product.new("Dove Soaps", 3999)
              product_b = Product.new("Axe Deo", 9999)

              @cart = described_class.new
              @cart.add(product: product_a, amount: 4)
              @cart.add(product: product_b, amount: 2)

              @cart.remove_item(product: product_a, amount: 1)
            end

            it 'The number of Dove Soaps should be 3' do
              expect(@cart.size).to eq(5)
            end

            it 'And the total & the sales tax should reflect the change' do
              expect(@cart.total_price(tax: true)).to eq(359.94)
            end

            it 'And the total tax should reflect the change' do
              expect(@cart.total_tax).to eq(39.99)
            end
          end
        end
      end
    end
  end
end
