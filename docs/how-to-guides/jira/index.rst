.. _jira:

:octicon:`git-pull-request` Jira and other Links
================================================

Links
~~~~~
Links to Jira objects are set directly in the Sphinx-Needs objects by using
`string-links <https://sphinx-needs.readthedocs.io/en/latest/configuration.html#needs-string-links>`__.

See the needs below.

Additonally, a string-links setting needs to be added to the ubproject.toml file.

.. code-block:: toml
    
    # ubproject.toml

    [needs.string_links.jira_link]
    # Links to the related jira issue
    link_name = "JIRA ADAS #{{value}}"
    link_url = "https://useblocks.atlassian.net/browse/ADAS-{{value}}"
    options = ["jira"]
    regex = "^(?P<value>\\w+)$"

... or to the conf.py file:

.. code-block:: python

    # conf.py
    needs_string_links = {
        'custom_name': {
            'regex': "...",
            'link_url' : "...",
            'link_name': '...'
            'options': ['status', '...']
        }
    }
    # Examples
    needs_string_links = {
        # Adds link to the Sphinx-Needs configuration page
        'config_link': {
            'regex': r'^(?P<value>\w+)$',
            'link_url': 'https://sphinx-needs.readthedocs.io/en/latest/configuration.html#{{value | replace("_", "-")}}',
            'link_name': 'Sphinx-Needs docs for {{value | replace("_", "-") }}',
            'options': ['config']
        },
        # Links to the related github issue
        'github_link': {
            'regex': r'^(?P<value>\w+)$',
            'link_url': 'https://github.com/useblocks/sphinx-needs/issues/{{value}}',
            'link_name': 'GitHub #{{value}}',
            'options': ['github']
        }
    }

.. need:: Lane Keeping Assistance
   :id: NEED_001
   :status: open
   :jira: 1

   The system shall detect lane markings and provide corrective steering input to keep the
   vehicle within the lane.

.. req:: Lane Detection Algorithm
   :id: REQ_001
   :status: open
   :links: NEED_001
   :jira: 3