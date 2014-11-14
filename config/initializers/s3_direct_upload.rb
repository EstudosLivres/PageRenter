S3DirectUpload.config do |c|
  aws_config = YAML.load_file("#{Rails.root.to_s}/config/aws.yml")
  aws_dev = aws_config['development']
  aws_prod = aws_config['production']

  # TODO substituir quando for pra produção
  aws = aws_dev

  c.access_key_id     = aws[:access_key_id]
  c.secret_access_key = aws[:secret_access_key]
  c.bucket            = aws[:bucket]
  c.region            = aws[:region]
  c.url = "https://s3.amazonaws.com/#{aws['bucket']}/"
end