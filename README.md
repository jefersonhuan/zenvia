# Zenvia

Esta biblioteca -**não oficial**- segue as diretivas da [documentação API REST da Zenvia](http://docs.zenviasms.apiary.io/#introduction/autenticacao). 

## Instalação

Adicione esta linha ao seu Gemfile

```ruby
gem 'zenvia-rb', '~> 0.1.0'
```

E depois execute:

    $ bundle

Ou instale através do "gem install":

    $ gem install zenvia-rb

A única dependência desta Gem é o HTTParty.

## Uso

Para usar esta biblioteca, [você vai precisar informar alguns dados](http://docs.zenviasms.apiary.io/#introduction/autenticacao), que são obtidos através da própria Zenvia.

```ruby
require 'zenvia'
  

Zenvia.configure {|config|
    config.account = 'SUA-CONTA'
    config.code = 'SEU-CODIGO'
    config.from = 'NOME-DA-EMPRESA-OU-PESSOA' # opcional
}
```
*Se você pretende usar esta Gem com Rails, insira o snippet acima em config/initializers.*

Feito isso, [para enviar uma mensagem](http://docs.zenviasms.apiary.io/#reference/servicos-da-api/envio-de-um-unico-sms/testar-envio-de-um-unico-sms), será preciso apenas chamar a função "send_message":

```ruby
options = {from: config.from, id: 'SEU-ID', schedule: '2017-07-18T02:01:23'}
Zenvia.send_message(number, message, options)
  
# no hash 'options', você ainda pode inserir o aggregateId. Todos esses valores são opcionais  
 
# Exemplo de resposta:
{"sendSmsResponse"=>{"statusCode"=>"00", "statusDescription"=>"Ok", "detailCode"=>"000", "detailDescription"=>"Message Sent"}}
```

Se preferir, você pode definir um array de números e enviar a **mesma** mensagem a eles:

```ruby

numbers = ['DDNNNNNNNNN', 'DDNNNNNNNNM']
Zenvia.send_message(numbers, message)
  

# Exemplo de resposta
 
[
  {"sendSmsResponse"=>{"statusCode"=>"00", "statusDescription"=>"Ok", "detailCode"=>"000", "detailDescription"=>"Message Sent"}}, 
  {"sendSmsResponse"=>{"statusCode"=>"00", "statusDescription"=>"Ok", "detailCode"=>"000", "detailDescription"=>"Message Sent"}}
]
```

Ou usar a função nativa do Zenvia, [de enviar múltiplos SMSs](http://docs.zenviasms.apiary.io/#reference/servicos-da-api/envio-de-varios-smss-simultaneamente/testar-envio-de-varios-smss-simultaneamente):

```ruby
list = [
 {
   from: "remetente",
   to: "555192551015",
   msg: "uma mensagem",
   callbackOption: "NONE"
 },
 {
   from: "remetente",
   to: "555199668010",
   schedule: "2014-07-18T02:01:23",
   msg: "outra mensagem",
   callbackOption: "NONE",
   id: "004"
 }
]  
  

Zenvia.send_multiple_messages list
```

Caso tenha definido o ID no envio de uma mensagem, poderá buscar seu status chamando a função "lookup":

```ruby
id = 'SEU-ID'  
    
Zenvia.lookup(id)
      

# Exemplo de resposta 
    
{"sendSmsResponse": {"statusCode": "00", "statusDescription": "Ok", "detailCode": "000", "detailDescription": "Message Sent" }}
```

Isso é tudo, pessoal!

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

