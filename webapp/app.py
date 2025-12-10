from flask import Flask, render_template, jsonify, request
import subprocess, os

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/fix')
def run_fix():
    try:
        output = subprocess.check_output(['bash', 'berzerk_fix.sh'], stderr=subprocess.STDOUT)
        return jsonify({'status': 'success', 'log': output.decode()})
    except subprocess.CalledProcessError as e:
        return jsonify({'status': 'error', 'log': e.output.decode()})

@app.route('/terminal', methods=['POST'])
def terminal():
    cmd = request.json.get("cmd")
    try:
        output = subprocess.check_output(cmd, shell=True, stderr=subprocess.STDOUT)
        return jsonify({'status': 'success', 'log': output.decode()})
    except subprocess.CalledProcessError as e:
        return jsonify({'status': 'error', 'log': e.output.decode()})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
