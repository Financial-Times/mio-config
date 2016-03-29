migrate 'create boobies S3 VFS thing' do
  s3 do |s|
    s.name = 'boobies_ingester'
    s.visibility = [4]
    s.key = 'some-bollocks'
    s.secret = 'some-secret-bollocks'
    s.bucket = 'my_fucking_bucket'
  end
end
