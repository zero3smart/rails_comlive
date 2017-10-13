def setup_knock
  request.headers['authorization'] = 'Bearer JWTTOKEN'
  knock = double("Knock")
  user = create(:user)
  yield user if block_given?
  allow(knock).to receive(:current_user).and_return(user)
  allow(knock).to receive(:validate!).and_return(true)
  allow(Knock::AuthToken).to receive(:new).and_return(knock)
end