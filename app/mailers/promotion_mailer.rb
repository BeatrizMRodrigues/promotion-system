class PromotionMailer < ApplicationMailer
  
  def approval_email
    mail(to: "mntrrdrgs@gmail.com", 
         subject: 'Sua promoção foi aprovada')
  end
end