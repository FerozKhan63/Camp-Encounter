class PaymentService
  require "braintree"

  def self.gateway
    gateway = Braintree::Gateway.new(
      environment: :sandbox,
      merchant_id: ENV["MERCHANT_ID"],
      public_key: ENV["PUBLIC_KEY"],
      private_key: ENV["PRIVATE_KEY"]
    )
  end

  def self.create_braintree_customer(user, params)
    if user.braintree_customer_id.blank?
        customer = Braintree::Customer.create(
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email
      )
      user.update(braintree_customer_id: customer.customer.id)
      braintree_customer = customer.customer
    else
      braintree_customer = Braintree::Customer.find(user.braintree_customer_id)
    end
    braintree_customer
  end

  def self.generate_token(user)
    if user.braintree_customer_id.blank?
      customer = create_braintree_customer(user, params)
      user.update(braintre_customer_id: customer.id)
    end
    gateway.client_token.generate(customer_id: user.braintree_customer_id)
  end

  def self.subscription(amount, params, user)
    byebug
    result = Braintree::Subscription.create({
        payment_method_nonce: params[:nonce],
        plan_id: "63hm",
        price: "#{amount}",
        discounts: {
          add: [
            {
              inherited_from_id: "vwcb"
            }
          ]
        }
    })
    
    result
  end

  def self.sale(amount, params, user)
    customer = create_braintree_customer(params, user)
    token_generated = customer.payment_methods[0].token

    result = gateway.transaction.sale(
      amount: amount,
      payment_method_token: token_generated,
      options: {
        submit_for_settlement: true
      }
    )
    result
  end
end
