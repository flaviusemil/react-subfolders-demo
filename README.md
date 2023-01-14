# React subpath demo

This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).

## How to check the demo?

Just open a terminal in the root project and run:
```bash
docker-compose up -d
```

This will create 3 docker services. 1 proxy to simulate the AWS ELB for example and 2 react dockerized apps.

The React app is a basic app bootstrapped with `create-react-app` the only changes to the app that I've made
was to add the `react-router-dom` and in the `createBrowserRouter` method to set the `basename` option to `/`.
It is possible to script that, but it's easier like this.

## How it works?
The `Dockerfile` contains all the logic that makes it work. To make it work under a sub-path you need to compile the app
with some options:
 1. In `package.json` you need to set the `homepage` property to the sub-path you want your app to be served under.
for example `app1`.
2. You need to add the same sub-path to your router. In this case I added it in the `basename` option
passed to `createBrowserRouter` method.

The problem is that both of the steps must be done at compile time, you can't do it at run time, so how does it work?
1. There is a command in the `Dockerfile` that appends the `homepage` property to the `package.json`
2. There is a command that patches the `main.jsx` file (for this example that's the file
where `createBrowserRouter` is called and where the `basename` is set).

Both values of the `homepage` and `basename` are placeholders. In the `Dockerfile` i used a UUID as a placeholder
since they are unique.

    Note that the placeholder can be updated when you do the docker build by passing an extra argument but you need
    to be careful areound the special characters.

Ex:
```bash
docker build -t your-image-tag --build-arg PLACEHOLDER=your_custom_placeholder .
```

The final thing that ties it all together is a entrypoint script that replaces the placeholder with the value from
a environment variable named `REACT_HOMEPAGE`.

    Note that REACT_HOMEPAGE is / by default.

## Available Scripts

In the project directory, you can run:

### `npm start`

Runs the app in the development mode.\
Open [http://localhost:3000](http://localhost:3000) to view it in your browser.

The page will reload when you make changes.\
You may also see any lint errors in the console.

### `npm test`

Launches the test runner in the interactive watch mode.\
See the section about [running tests](https://facebook.github.io/create-react-app/docs/running-tests) for more information.

### `npm run build`

Builds the app for production to the `build` folder.\
It correctly bundles React in production mode and optimizes the build for the best performance.

The build is minified and the filenames include the hashes.\
Your app is ready to be deployed!

See the section about [deployment](https://facebook.github.io/create-react-app/docs/deployment) for more information.

### `npm run eject`

**Note: this is a one-way operation. Once you `eject`, you can't go back!**

If you aren't satisfied with the build tool and configuration choices, you can `eject` at any time. This command will remove the single build dependency from your project.

Instead, it will copy all the configuration files and the transitive dependencies (webpack, Babel, ESLint, etc) right into your project so you have full control over them. All of the commands except `eject` will still work, but they will point to the copied scripts so you can tweak them. At this point you're on your own.

You don't have to ever use `eject`. The curated feature set is suitable for small and middle deployments, and you shouldn't feel obligated to use this feature. However we understand that this tool wouldn't be useful if you couldn't customize it when you are ready for it.

## Learn More

You can learn more in the [Create React App documentation](https://facebook.github.io/create-react-app/docs/getting-started).

To learn React, check out the [React documentation](https://reactjs.org/).

### Code Splitting

This section has moved here: [https://facebook.github.io/create-react-app/docs/code-splitting](https://facebook.github.io/create-react-app/docs/code-splitting)

### Analyzing the Bundle Size

This section has moved here: [https://facebook.github.io/create-react-app/docs/analyzing-the-bundle-size](https://facebook.github.io/create-react-app/docs/analyzing-the-bundle-size)

### Making a Progressive Web App

This section has moved here: [https://facebook.github.io/create-react-app/docs/making-a-progressive-web-app](https://facebook.github.io/create-react-app/docs/making-a-progressive-web-app)

### Advanced Configuration

This section has moved here: [https://facebook.github.io/create-react-app/docs/advanced-configuration](https://facebook.github.io/create-react-app/docs/advanced-configuration)

### Deployment

This section has moved here: [https://facebook.github.io/create-react-app/docs/deployment](https://facebook.github.io/create-react-app/docs/deployment)

### `npm run build` fails to minify

This section has moved here: [https://facebook.github.io/create-react-app/docs/troubleshooting#npm-run-build-fails-to-minify](https://facebook.github.io/create-react-app/docs/troubleshooting#npm-run-build-fails-to-minify)
