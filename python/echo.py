#!/usr/bin/env python3


from flask import Flask, request, jsonify, abort


app = Flask(__name__)


@app.route('/api/v1/echo', methods=['POST'])
def echo():
    if request.method == 'POST':
        data = request.get_json() or request.values
        return jsonify(isError=False, message="Success", statusCode=200, data=data), 200
    else:
        abort(400)


if __name__ == '__main__':
    app.run('0.0.0.0', port=80, debug=True)
