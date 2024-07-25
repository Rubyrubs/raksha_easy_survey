// app/javascript/packs/survey_edit.js

document.addEventListener('DOMContentLoaded', () => {
  const toolbox = document.getElementById('toolbox');
  const surveyContainer = document.getElementById('survey-container');

  toolbox.addEventListener('dragstart', (e) => {
    e.dataTransfer.setData('text/plain', e.target.id);
  });

  surveyContainer.addEventListener('dragover', (e) => {
    e.preventDefault();
  });

  surveyContainer.addEventListener('drop', (e) => {
    e.preventDefault();
    const componentType = e.dataTransfer.getData('text/plain');
    const component = document.createElement('div');
    component.classList.add('component');
    component.draggable = true;

    if (componentType === 'label-tool') {
      component.innerHTML = 'Double-click to edit label';
      component.classList.add('label');
    } else if (componentType === 'input-tool') {
      component.innerHTML = '<input type="text" value="Input Text">';
      component.classList.add('input');
    }

    surveyContainer.appendChild(component);

    component.addEventListener('dblclick', () => {
      if (component.classList.contains('label')) {
        const newText = prompt('Edit label text:', component.textContent);
        if (newText !== null) {
          component.textContent = newText;
        }
      }
    });

    // Save component to the server
    fetch(`/surveys/${surveyId}/components`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({
        component: {
          component_type: componentType,
          content: componentType === 'label-tool' ? 'Double-click to edit label' : 'Input Text',
          position_x: component.style.left,
          position_y: component.style.top
        }
      })
    });
  });
});
