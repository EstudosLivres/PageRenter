S3DirectUpload.config do |c|
  aws_config = YAML.load_file("#{Rails.root.to_s}/config/aws.yml")
  aws_dev = aws_config['development']
  aws_prod = aws_config['production']

  # TODO substituir quando for pra produção
  aws = aws_dev

  c.access_key_id     =
  c.secret_access_key =
  c.bucket            =
  c.region            = 's3'
  c.url = "https://s3.amazonaws.com/#{aws['bucket']}/"
end