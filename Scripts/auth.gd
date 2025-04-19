extends Node

var access_token := ""
var id_token := ""

func start_login():
	var state = generate_random_state(45)

	OS.shell_open("http://localhost:3000/login/")

#func handle_redirect(url: String):
	#var code = _extract_param_from_url(url, "code")
	#var state = _extract_param_from_url(url, "state")
	#if code != "":
		#_exchange_code_for_token(code, state)

#func _exchange_code_for_token(code: String, state: String):
	#var http := HTTPRequest.new()
	#add_child(http)
	#
	#var token_url = "%s/oauth/token" % AUTH0_DOMAIN
	#var body = {
		#"grant_type": "authorization_code",
		#"client_id": CLIENT_ID,
		#"code": code,
		#"redirect_uri": REDIRECT_URI,
		#"provider": "auth0",
		#"state": state,
		#"code_verifier": "your_verifier"  # Save this securely during PKCE generation
	#}
	#
	#var headers = ["Content-Type: application/json"]
	#var json_body = JSON.stringify(body)
#
	#http.request(token_url, headers, HTTPClient.METHOD_POST, json_body)
	#await http.request_completed
	#
	#var response = http.get_body_as_string()
	#var result = JSON.parse_string(response)
	#
	#if result and result.has("access_token"):
		#access_token = result["access_token"]
		#id_token = result["id_token"]
		#print("✅ Auth success: ", access_token)
	#else:
		#print("❌ Auth failed: ", result)

func _extract_param_from_url(url: String, param: String) -> String:
	var paramValue = ""
	if url.find(param+"=") != -1:
		paramValue = url.get_slice(param+"=", 1).split("&")[0]
	return paramValue

func generate_code_challenge() -> String:
	# Ideally generated with PKCE helper on server and shared via local storage or session
	return "your_precomputed_challengeyour_precomputed_challengeyour"
	
func generate_random_state(length := 32) -> String:
	var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	var state = ""
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	for i in length:
		state += chars[rng.randi_range(0, chars.length() - 1)]
	return state
