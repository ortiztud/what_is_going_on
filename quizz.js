// Define questions
var myQuestions = [
	{
		question: "If P = .05, the null hypothesis has only a 5% chance of being true",
		correctAnswer: 'b'
	},
	{
		question: "A nonsignificant difference (eg, P >.05) means there is no difference between groups.",
		correctAnswer: 'b'
	},
	{
		question: "A statistically significant finding is clinically important.",
		correctAnswer: 'b'
	},
	{
		question: "Studies with P values on opposite sides of .05 are conflicting.",
		correctAnswer: 'b'
	},
	{
		question: "P = .05 means that we have observed data that would occur only 5% of the time under the null hypothesis.",
		correctAnswer: 'b'
	},
	{
		question: "P =.05 and P <.05 mean the same thing.",
		correctAnswer: 'b'
	},
	{
		question: "P values are properly written as inequalities (eg, “P <.02” when P = .015).",
		correctAnswer: 'b'
	},
	{
		question: "P = .05 means that if you reject the null hypothesis, the probability of a type I error is only 5%",
		correctAnswer: 'b'
	},
	{
		question: "With a P = .05 threshold for significance, the chance of a type I error will be 5%.",
		correctAnswer: 'b'
	},
	{
		question: "You should use a one-sided P value when you don’t care about a result in one direction, or a difference in that direction is impossible.",
		correctAnswer: 'b'
	},
	{
		question: "A scientific conclusion or treatment policy should be based on whether or not the P value is significant.",
		correctAnswer: 'b'
	}
];

var options =
	{
		answers: {
			a: 'TRUE',
			b: 'FALSE'
		}
	}
;	

// Get placeholders from the html file based on their id.
var quizContainer = document.getElementById('quiz');
var resultsContainer = document.getElementById('results');
var submitButton = document.getElementById('submit');
var wayout_container = document.getElementById('way_out');

// Generate the quizz
generateQuiz(myQuestions, quizContainer, resultsContainer, submitButton);

// Functions
function generateQuiz(questions, quizContainer, resultsContainer, submitButton){

	function showQuestions(questions, quizContainer){
	// we'll need a place to store the output and the answer choices
	var output = [];
	var answers;

	// for each question...
	for(var i=0; i<questions.length; i++){
		
		// first reset the list of answers
		answers = [];

		// for each available answer to this question...
		//for(letter in questions[i].answers){
		for(letter in options.answers){
			// ...add an html radio button
			answers.push(
				'<label>'
					+ '<input type="radio" name="question'+i+'" value="'+letter+'">'
					+ letter + ': '
					+ options.answers[letter]
				+ '</label>'
			);
		}

		// add this question and its answers to the output
		output.push(
			'<div class="question">' + questions[i].question + '</div>'
			+ '<div class="answers">' + answers.join('') + '</div>'
		);
	}

	// finally combine our output list into one string of html and put it on the page
	quizContainer.innerHTML = output.join('');
	}

	function showResults(questions, quizContainer, resultsContainer){
		// gather answer containers from our quiz
	var answerContainers = quizContainer.querySelectorAll('.answers');
	
	// keep track of user's answers
	var userAnswer = '';
	var numCorrect = 0;
	
	// for each question...
	for(var i=0; i<questions.length; i++){

		// find selected answer
		userAnswer = (answerContainers[i].querySelector('input[name=question'+i+']:checked')||{}).value;
		
		// if answer is correct
		if(userAnswer==='b'){
			// add to the number of correct answers
			numCorrect++;
			
			// color the answers green
			answerContainers[i].style.color = 'lightgreen';
		}
		// if answer is wrong or blank
		else{
			// color the answers red
			answerContainers[i].style.color = 'red';
		}
	}

	// show number of correct answers out of total
	resultsContainer.innerHTML = numCorrect + ' out of ' + questions.length;

	// display feedback based on performance and give option to go back
	if(numCorrect==questions.length){
		wayout_container.innerHTML = 'Yay! You are a true p value pro. Wanna try with effect sizes?'
	}else{
		wayout_container.innerHTML = 'Ok, I get it. I need to learn more about it.' + '<a href="index.md">Take me to main site.</a></div>';
	}
	

	}

	// show the questions
	showQuestions(questions, quizContainer);

	// when user clicks submit, show results
	submitButton.onclick = function(){
		showResults(questions, quizContainer, resultsContainer);
	}
}



