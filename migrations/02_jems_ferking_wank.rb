migrate 'create boobies S3 VFS thing' do
  s3 do |s|
    s.name = 'jems_ingester'
    s.visibility = [4]
    s.key = 'some-bollocks'
    s.secret = 'some-secret-bollocks'
    s.bucket = 'jems_shite_bucket'
  end
end
