# BaseCampaign
puts 'Inserting Campaign...'.colorize(:green)
  advertiser = User.where(email:'aa@pt.pt').take.advertiser
  advertiser.campaigns << Campaign.create({name:'Dia das mãe', launch_date:Time.now, end_date:(DateTime.now+4)})
  advertiser.save
  puts "\t #{advertiser.campaigns}"
puts '...Campaign inserted.'.colorize(:light_blue)
# /BaseCampaign

# BaseAds
puts 'Inserting Ads...'.colorize(:green)
  campaign = advertiser.campaigns.first
  campaign.ads << Ad.new({name:'Dia das mães', title:'Faça sua mãe trocar o sapato pelo tênis', username:'dias-das-maes', description:'Lorem ipsum lati amet inother amerium.', social_phrase:'Partiu tênis', redirect_link:'http://pagerenter.com.br'})
  campaign.ads << Ad.create({name:'Cupom de desconto', title:'Cupom de desconto', username:'cuprom-desconto', description:'Lorem ipsum lati amet inother amerium.', social_phrase:'Partiu cupom', redirect_link:'http://pagerenter.com.br'})
  campaign.save
  puts "\t #{campaign.ads.first}"
  puts "\t #{campaign.ads.second}"
puts '...Ads inserted.'.colorize(:light_blue)
# /BaseAds