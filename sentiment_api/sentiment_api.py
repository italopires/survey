from flask import Flask, request, jsonify
import spacy

app = Flask(__name__)

# Load portuguese model
nlp = spacy.load("pt_core_news_sm")

# Feeling Dictionary for analysis
positive_words = {"bom", "ótimo", "excelente", "positivo", "agradável", "feliz", "acolhedor", "eficiente", "saudável",
  "acolhedor", "adequado", "acessivel", "alinhada", "atrativos", "autonomia",
  "boa", "boas", "capacitacao", "clareza", "colaborativa", "competitiva", "construtiva",
  "criatividade", "desafiadores", "dinamico", "diversidade", "eficazes", "eficiente",
  "empatia", "excelente", "forte", "fortalecem", "honestidade", "impacto", "inovacao",
  "inspiradora", "justos", "modernos", "motivadora", "positiva",
  "recompensas", "reconhecimento", "respeitado", "respeito", "satisfeito", "saudavel",
  "transparencia", "valorizadas", "valorizam" }

negative_words = {"ruim", "péssimo", "horrível", "negativo", "triste", "desagradável", "injusto", "estressante",
  "afeta", "burocraticos", "confusa", "confuso", "dificultam", "estagnado", "estresse",
  "excessiva", "falta", "fraca", "fraco", "ineficaz", "insuficiente", "limitadas",
  "malentendidos", "nao", "pouco", "problemas"
}

@app.route("/analyze", methods=["POST"])
def analyze():
    data = request.get_json()
    comment = data.get("comment")

    if not comment:
        return jsonify({"error": "Missing comment"}), 400

    doc = nlp(comment)

    tokens = [token.lemma_.lower() for token in doc if not token.is_stop and not token.is_punct]

    positives = [t for t in tokens if t in positive_words]
    negatives = [t for t in tokens if t in negative_words]

    if len(positives) > len(negatives):
        feeling = "positive"
    elif len(negatives) > len(positives):
        feeling = "negative"
    else:
        feeling = "neutral"

    return jsonify({
        "comment": comment,
        "preprocessed_tokens": tokens,
        "positive_findings": positives,
        "negative_findings": negatives,
        "feeling": feeling
    })

if __name__ == "__main__":
    app.run(debug=True, port=5001, host="0.0.0.0")
