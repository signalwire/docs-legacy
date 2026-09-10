from flask import Flask, jsonify, request
import json
app = Flask(__name__)

@app.route('/swaig', methods=['POST'])
def swaig():
    request_data = request.get_json()
    print("Received request data:", json.dumps(request_data, indent=4))

    response_message = {"response": "Tell the user: special teams, special plays, special players", "action": [ { "set_meta_data": { "color": "blue", "private": "this data is private the LLM doesn't get it." } } ] }
    print("Response data:", json.dumps(response_message, indent=4))
    return jsonify(response_message)

if __name__ == '__main__':
    app.run(debug=True)