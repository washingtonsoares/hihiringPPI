class UserMailer < ActionMailer::Base
  default from: "washingtonudi@gmail.com"
  def indicate_student(indicator,indicate_to,dadosindicate)
    @indicador = indicator
    @aluno     = indicate_to
    @email_aluno = dadosindicate[:email]
    @observacao = dadosindicate[:obs]
    mail(to: dadosindicate[:email], subject: 'Indicação de um bom profissional')
  end
end
