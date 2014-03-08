Rails.application.config.middleware.use OmniAuth::Builder do
  ENV["GOOGLE_CLIENT_ID"] = "232405294227-he7jlmkph6ha0cq2euougoe2nr2s3pml.apps.googleusercontent.com";
  ENV["GOOGLE_CLIENT_SECRET"] = "84fWdJHFroRNRca95afxwiJJ";

  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"]
end
