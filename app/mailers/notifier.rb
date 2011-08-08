class Notifier < ActionMailer::Base  
  default :from => "from@example.com"  
  # Subject can be set in your I18n file at config/locales/en.yml  
  # with the following lookup:  
  #  
  #   en.notifier.order_received.subject  
  #  
  def order_received(order)    
    @order = order      
    @address = Address.find(order.address_id)  
    @user = User.find(@address.user_id)
    mail :to => @user.email, :subject => 'Pragmatic Store Order Confirmation'  
  end  
  
  # Subject can be set in your I18n file at config/locales/en.yml  
  # with the following lookup:  
  #  
  #   en.notifier.order_shipped.subject  
  #  
  def order_shipped(order)    
    @order = order  
    @address = Address.find(order.address_id)  
    @user = User.find(@address.user_id)  
    mail :to => @user.email, :subject => 'Pragmatic Store Order Shipped'  
  end
end