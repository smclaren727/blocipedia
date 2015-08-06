class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.name}",
      amount: 1500
    }
  end

  def create

    #default amount in cents
    @amount = 1500
   
    # Creates a Stripe Customer object, for associating with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
   
    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: @amount,
      description: "Wiki Membership - #{current_user.email}",
      currency: 'usd'
    )
		current_user.update_to_premium
    flash[:success] = "Your payment was received, #{current_user.email}! Enjoy your premium membership."
    redirect_to wikis_path
   
   # Stripe will send back CardErrors, with friendly messages
   # when something goes wrong.
   # This `rescue block` catches and displays those errors.
   rescue Stripe::CardError => e
     flash[:error] = e.message
     redirect_to new_charge_path
  end
end
