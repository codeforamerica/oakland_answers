require 'spec_helper'

describe PersonaController do
  describe "#login" do
    context "with a cfa email address" do
      before do
        allow(controller).to receive(:get_identity) { "erica@cfa.org" }
      end

      it "sets a session variable when an identity is found" do
        xhr :post, :login
        expect(session[:email]).to eq("erica@cfa.org")
      end

      it "renders json with a redirect location" do
        user = FactoryGirl.create(:user, email: "erica@cfa.org")
        xhr :post, :login
        expect(response.body).to eq({location: root_url}.to_json)
      end

      it "should create a user" do
        expect { xhr :post, :login }.to change(User, :count).by(1)
      end
    end
  end

  describe "#logout" do
    before do
      session[:email] = "erica@cfa.org"
      xhr :post, :logout
    end

    it "sets the session variable to nil" do
      expect(session[:email]).to be_nil
    end

    it "renders json with a redirect location" do
      expect(response.body).to eq({location: root_url}.to_json)
    end
  end

  describe "#get_identity" do
    let(:assertion) { "stuff" }

    it "returns an email address when mozilla confirms the identity assertion" do
      response_body = <<-eos
              {
              "status": "okay",
              "email": "erica@cfa.org",
              "audience": "https://engine-light.cfa.org",
              "expires": 1308859352261,
              "issuer": "cfa.org"
             }
             eos
      stub_request(:post, "https://verifier.login.persona.org/verify").to_return(status: 200, headers: {}, body: response_body)
      expect(controller.get_identity(assertion)).to eq("erica@cfa.org")
    end

    it "returns nil when mozilla rejects the identity assertion" do
      response_body = "{}"
      stub_request(:post, "https://verifier.login.persona.org/verify").to_return(status: 200, headers: {}, body: response_body)
      expect(controller.get_identity(assertion)).to be_nil
    end

    it "raises if the post does not return ok" do
      stub_request(:post, "https://verifier.login.persona.org/verify").to_return(status: ["500", "Internal Server Error"])
      expect { controller.get_identity(assertion) }.to raise_error
    end
  end
end
