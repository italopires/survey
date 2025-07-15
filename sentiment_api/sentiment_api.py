from flask import Flask, request, jsonify
from transformers import pipeline

app = Flask(__name__)

# Carrega o modelo de sentimento multilíngue
sentiment_pipeline = pipeline("sentiment-analysis", model="nlptown/bert-base-multilingual-uncased-sentiment")

@app.route("/analyze", methods=["POST"])
def analyze():
    data = request.get_json()
    comment = data.get("comment")

    if not comment:
        return jsonify({"error": "Missing comment"}), 400

    result = sentiment_pipeline(comment)[0]

    # Interpreta a nota como sentimento
    score_map = {
        "1 star": "muito negativo",
        "2 stars": "negativo",
        "3 stars": "neutro",
        "4 stars": "positivo",
        "5 stars": "muito positivo"
    }

    return jsonify({
        "comment": comment,
        "label": score_map.get(result["label"], "desconhecido"),
        "raw_label": result["label"],
        "confidence": result["score"]
    })

if __name__ == "__main__":
    app.run(debug=True, port=5001, host="0.0.0.0")
