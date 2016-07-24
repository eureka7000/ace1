json.array!(@inicis_payments) do |inicis_payment|
  json.extract! inicis_payment, :id, :version, :mid, :oid, :good_name, :price, :tax, :tax_free, :currency, :buyer_name, :buyer_tel, :buyer_email, :parent_email, :timestamp, :, :signature, :return_url, :m_key, :go_pay_method, :offer_period
  json.url inicis_payment_url(inicis_payment, format: :json)
end
