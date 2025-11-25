import styles from "styles/Layout.module.scss"; // Styles
import { default as HTMLHead } from "next/head"; // Meta

// Page layout
export default function Layout({
  children,
}: {
  children: (JSX.Element | null)[];
}) {
  return (
    <div className={styles.layout}>
      {/* Meta + Head */}
      <Head />

      {/* Layout sizer */}
      <div className={styles.layout__content}>{children}</div>

      {/* Footer */}
      <Footer />
    </div>
  );
}

// Head + Meta
function Head() {
  return (
    <HTMLHead>
      {/* Google Fonts */}
      <link rel="preconnect" href="https://fonts.googleapis.com" />
      <link
        rel="preconnect"
        href="https://fonts.gstatic.com"
        crossOrigin="true"
      />
      <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap"
        rel="stylesheet"
      />

      {/* Favicon */}
      <link rel="shortcut icon" href="/favicon.ico" />

      {/* Primary Meta Tags */}
      <title>Seismic Faucet | Bootstrap your testnet/devnet wallet</title>
      <meta
        name="title"
        content="Seismic Faucet | Bootstrap your testnet/devnet wallet"
      />
      <meta
        name="description"
        content="MultiFaucet funds a wallet with ETH, wETH, DAI, and NFTs across 8 testnet networks, at once."
      />

      {/* OG + Facebook */}
      <meta property="og:type" content="website" />
      <meta property="og:url" content="https://faucet.seismic.systems" />
      <meta
        property="og:title"
        content="Seismic Faucet | Bootstrap your testnet wallet"
      />
      <meta
        property="og:description"
        content="MultiFaucet funds a wallet with ETH, wETH, DAI, and NFTs across 8 testnet networks, at once."
      />
      <meta
        property="og:image"
        content="https://faucet.seismic.systems/meta.png"
      />

      {/* Twitter */}
      <meta property="twitter:card" content="summary_large_image" />
      <meta property="twitter:url" content="https://faucet.seismic.systems" />
      <meta
        property="twitter:title"
        content="Seismic Faucet | Bootstrap your testnet wallet"
      />
      <meta
        property="twitter:description"
        content="MultiFaucet funds a wallet with ETH, wETH, DAI, and NFTs across 8 testnet networks, at once."
      />
      <meta
        property="twitter:image"
        content="https://faucet.seismic.systems/meta.png"
      />
    </HTMLHead>
  );
}

// Footer
function Footer() {
  return (
    <div className={styles.layout__footer}>
      {/* Credits */}
      <p style={{ fontSize: '14px', color: '#666' }}>
        Built with immense gratitude based on the original{' '}
        <a 
          href="https://faucet.paradigm.xyz" 
          target="_blank" 
          rel="noopener noreferrer"
          style={{ color: '#0070f3', textDecoration: 'none' }}
        >
          MultiFaucet
        </a>{' '}
        created by {' '}
        <a 
          href="https://github.com/Anish-Agnihotri" 
          target="_blank" 
          rel="noopener noreferrer"
          style={{ color: '#0070f3', textDecoration: 'none' }}
        >
          Anish Agnihotri
        </a>{' '}
        and the incredible team at{' '}
        <a 
          href="https://paradigm.xyz" 
          target="_blank" 
          rel="noopener noreferrer"
          style={{ color: '#0070f3', textDecoration: 'none' }}
        >
          Paradigm
        </a>. 
        Their pioneering work in developer tooling and infrastructure has made projects like this possible. 
        We are deeply thankful for their contributions to the OSS blockchain ecosystem.
      </p>
      
      {/* Disclaimer */}
      <p style={{ marginTop: '20px' }}>
        These smart contracts are being provided as is. No guarantee,
        representation or warranty is being made, express or implied, as to the
        safety or correctness of the user interface or the smart contracts. They
        have not been audited and as such there can be no assurance they will
        work as intended, and users may experience delays, failures, errors,
        omissions or loss of transmitted information. Seismic is not liable for
        any of the foregoing. Users should proceed with caution and use at their
        own risk.
      </p>
    </div>
  );
}
